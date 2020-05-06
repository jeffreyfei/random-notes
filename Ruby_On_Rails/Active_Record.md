# Active Records
- A layer responsible for representing business data and logic

## Naming Conventions
- lower case separated by underscores
- Plural
  - e.g. LineItem => line_items

## CRUD
### Create
```ruby
  # Create and save to the data base
  user = User.create(name: "some_name" occupation: "some_info")

  # Create an object without saving
  user = User.new
  user.name = "some_name"
  user.occupation = "some_info"
  # commit to the database
  user.save

  # Using block
  user = User.new do |u|
    u.name = "some_name"
    u.occupation = "some_info"
  end
```
### Read
```ruby
  # return a collection with all users
  users = User.all
  # return first user
  user = User.first
  # return the first user with a given name
  user = User.find_by(name: 'some_given_user')
  # find all users with the given properties and sort by create_at in reverse
  # chronological order
  users = User.where(name: 'some_given_name', occupation: 'some_given_occ')
                                                    .order(created_at :desc)

```
More on Query Interface:

http://guides.rubyonrails.org/active_record_querying.html

### Update
- Can be achieved using the find_by method to query the item, update the object,
and call save a shorthand for this would be
```ruby
  user = user.find_by(name: 'some_given_user')
  user.update(name: 'new_name')
```
- Update attributes in bulk
```ruby
  # update_all(updates, conditions = nil, options = {})
  # updates: a string of column/value pairs that will be set on any record matching the conditions
  # conditions: outlines which records will be applied with the updates
  # options: e.g. :limit, :order  

  # Update all billing objects with the 3 different attributes given
  Billing.update_all( "category = 'authorized', approved = 1, author = 'David'" )

  # Update records that match our conditions
  Billing.update_all( "author = 'David'", "title LIKE '%Rails%'" )

  # Update records that match our conditions but limit it to 5 ordered by date
  Billing.update_all( "author = 'David'", "title LIKE '%Rails%'",
                        :order => 'created_at', :limit => 5 )
```
More Info:

https://apidock.com/rails/ActiveRecord/Base/update_all/class
### Delete
- Query the record object and call destroy on the object
```ruby
    user = User.find_by(name: 'given_name')
    user.destroy
```

## Validation
- Done in the derived ApplicationRecord classes with the validates keyword
- After validation is set, calling the update method will return a boolean value,
which indicates if the validation is successful
  - This information can then be used to handle the the invalid input e.g. inform
  the user
```ruby
  validates :id, conditions

  record_obj.valid? # Returns a boolean, indicates if the entry is valid
  record_obj.errors.messages # Returns a hash with the respective error messages
```
- Some methods skips validations, check the documentation for more details

#### Things that you can validate
**presence** - Make sure the field is not nil

**absence** - Opposite of  presence

**acceptance** - Validates a checkbox (e.g. terms for service)

**validates_associated** - Validates associations with other models

**confirmation** - When two textfields should receive the exact same content (e.g. email confirmation)

**exclusion** - Validates that the given attribute values are not included

**format** - Validates the format of the value (using regex)

**inclusion** - Make sure the entered value are included in a given set

**length** - self explanatory

**numericality** - validates numeric values

**uniqueness** - validates if the value is unique in the model

**validates_with** - validates with a validation class for more complex validations

#### Validation Options

**allow_nil, allow_blank** - Allows validations to be skipped if the value is
nil or blank respectively

#### Conditional validation
**on** - allows you to specify when validation should happen (e.g. when a
certain method is called)

**if/unless** - validate the object based on a given boolean expression

## Migrations
- Each migration is like a new "version" of the database
  - Add/remove tables, columns, or entries in each migration
- A migration can be rolled back
- Stored in db/migrate
  - Each files has a timestamp. The order of the migration is determined by the timestamp
- The change method is the primary way of writing migrations
  - There is a list of available methods on the webpage

- Editing existing migrations is not a good idea
  - If an existing migration is being ran, running it again will do nothing since
  rails thinks it has already run the migration
  - It is a good idea to always writing new migrations
#### Creating a table
```ruby
  # Create new table with column name
  create_table :table_name do |t|
    t.string :name
  end
```
#### Changing a table
```ruby
  change_table :table_name do |t|
    t.remove :description, :name
    t.string :new_col
    t.index :new_col
    t.rename :old :new
  end
```
- An "id" is created by default as the primary key
```ruby
  # Change a column to type text
  change_column :table_name, :col_name, :text
  # Change null constraint
  change_column_null :table_name, :col_name, false
  # Change default value from true to false
  change_column_default :table_name, :col_name, from: true, to: false
```

#### Foreign Keys
```ruby
  # Creates a foreign key
  add_foreign_key :table_name, :key_name
  # Remove a foreign key, let Active Record figure out the column name
  remove_foreign_key :table_name, :key_name  
```
#### Running/Rolling back migrations
- Run the migration up to the given timestamp
```
  bin/rails db:migrate VERSION=<timestamp>
```
- Rollback the latest migration
```
  bin/rails db:rollback
```
- rollback the last 3 migrations
```
  bin/rails db:rollback STEP=3
```
- rollback and migrate back up again
```
  bin/rails db:migrate:redo STEP=3  
```
- Running the specific migration of the given timestamp
```
  bin/rails db:migrate:up VERSION=<timestamp>
```
#### Schema Dumps
- rb files within the db directory
- Looks like giant migration files
- Represent the current state of the database
- Cannot express database specific items (triggers, stored procedures, check
  constraints etc.)

## Callbacks
```ruby
class User < ApplicationRecord
  before_validation :my_callback
  after_validation do
    # Callback as a block
  end
  end
  private
    def my_callback
      # Do something
    end
end
```
- **before_validation** is a callback option. For all the available options check
  the webpage
- There are different actions that triggers callbacks (check the complete list
  on the doc page)
- Can be called conditionally (if/unless)
```ruby
  before_validation :my_callback, if: :symbol?
  # Multiple conditions
  before_validation :my_callback, if: :symbol?, unless: {}
```
#### Callback classes
- Make the reuse of callback methods possible
```ruby
  class MyCallbacks
    def self.after_destroy(item)
      # Do something
    end
  end
```
```ruby
  class MyClass < ApplicationRecord
    after_destroy MyCallbacks
  end
```
- Note that we declared the method as a class method. If we declare callbacks
  as instance methods we need to call MyCallbacks.new instead

## Associations
- An association is a connection between two Active Record model in order to Make
  common operations simple
#### Belongs to
- Sets up a one-to-one connection with another model, such that each instance of
  the model belongs to one instance of the other model
```ruby
  class Book < ApplicationRecord
    belongs_to :author
  end
```
#### Has one
- A one-to-one relationship with different semantics
```ruby
  class Supplier < ApplicationRecord
    has_one :account
  end
```
#### Has many
- Each instance of the model has zero or more instances of the other model
- Similar to belongs_to
```ruby
  class Author < ApplicationRecord
    has_many :books
  end
```
#### Through
- The :through keyword creates a many to many relationship through a third class
  when used with has_many
  - One to one if used has_one
```ruby
  class Document < ApplicationRecord
    has_many :sections
    has_many :paragraphs, through: :sections
  end
```
#### Polymorphic associations
- When a model belongs to more than one other model

#### Self joins
- A model having an association with itself (e.g. Managers/Employees are both the
  Employee class but Employees belongs to manager)

#### Scoping
- Use modules to create different scopes

```ruby
module MyApplication
  # Same scope
  module Business
    class Supplier < ApplicationRecord
      has_one :account
    end
    class Account < ApplicationRecord
      belongs_to :Supplier
    end
  end
end
```

```ruby

module MyApplication
  # Different scope, must specify full class declaration
  module Business
    class Supplier < ApplicationRecord
      has_one :account, class_name: "MyApplication::Billing::Account"
    end
  end
  module Billing
    class Account < ApplicationRecord
      belongs_to :Supplier, class_name: "MyApplication::Business::Supplier"
    end
  end
end
```
### Links:
http://guides.rubyonrails.org/active_record_basics.html

http://guides.rubyonrails.org/active_record_validations.html

http://guides.rubyonrails.org/active_record_migrations.html

http://guides.rubyonrails.org/active_record_callbacks.html

http://guides.rubyonrails.org/association_basics.html