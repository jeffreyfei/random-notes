## Basics
- Rails is based on MVC

## Starting a Project
#### Creating a new Project
```
  rails new <project_name>
```
#### Controller
Create a new Controller
```
  rails generate controller <controller_name>
```

- Controller source file locatedat app/controllers/controller_name.rb
- Methods inside controllers are actions, and every action has views associated
with it
  - Views are located in app/views/controller_name/action_name.html.erb
  - You need to create a new view file in this format when a new action is created

#### Model
Create a Model
```
  rails generate model <model_name> <attr_1_name>:<type> <attr_2_name>:<type>
```
- Creates the table of the model and add the given attributes to the table
- For more information read Active Record

Link:

http://guides.rubyonrails.org/active_record_migrations.html

#### Rendering
```
  <%= link_to 'link_text', controller: 'controller_name' %>
```
- Creates a link to the corresponding view of the specified controller
Helpful Links:

http://guides.rubyonrails.org/layouts_and_rendering.html
#### Helpers

Helpful Links:

https://mixandgo.com/blog/the-beginners-guide-to-rails-helpers