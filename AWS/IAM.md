# Identity and Access Management

* Can be accessed through Services &gt; IAM

* **Manage IAM Users and their access** - you can create Users and assign them individual security credentials
* **Manage IAM Roles and their permissions** - what the identity can and cannot do in AWS; a Role is intended to be assumable by anyone who needs it
* **Manage federated users and their permissions** - refers to allow existing users in your enterprise to access the AWS Management Console

* Users and groups can be assigned pre-built policies \(_Managed Policy_\) by AWS or the system's administrator
  * When the policy is updated, the change is immediately applied against all Users and Groups attached to the policy
* _Inline Policies_ are ones that's assigned only to one user or group

### Basic Policy Structure

* **Effect** - whether allow or deny the permissions
* **Action** - specifies the API calls that can be made against an AWS service
* **Resource** - defines the scope of entities covered by the policy rule



