

[Samples from alex-magnay-azure-infrastructure](https://www.slideshare.net/WinOpsConf/alex-magnay-azure-infrastructure-as-code-with-hashicorp-terraform)

What is Terraform?
March of 2016 - Terraform support managing Azure resources in ()
August 2017 - HashiCorp announced a multi-year collaboration with MS

A way to manage Azure

Domain Specific Language (specify what that is - HCL, Hashicorp Configuration Language) - strike a balance between human readable and editable as well as being machine-friendly. For machine-friendliness, Terraform can also read JSON configurations. For general Terraform configurations, however

HCL is heavily inspired by libucl, nginx configuration, and others similar

Delcarative (explain)
Basic bullet point reference:

Single line comments start with #

Multi-line comments are wrapped with /* and */

Values are assigned with the syntax of key = value (whitespace doesn't matter). The value can be any primitive (string, number, boolean), a list, or a map.

Strings are in double-quotes.

Strings can interpolate other values using syntax wrapped in ${}, such as ${var.foo}. The full syntax for interpolation is documented here.

Multiline strings can use shell-style "here doc" syntax, with the string starting with a marker like <<EOF and then the string ending with EOF on a line of its own. The lines of the string and the end marker must not be indented.

Numbers are assumed to be base 10. If you prefix a number with 0x, it is treated as a hexadecimal number.

Boolean values: true, false.

Lists of primitive types can be made with square brackets ([]). Example: ["foo", "bar", "baz"].

Maps can be made with braces ({}) and colons (:): { "foo": "bar", "bar": "baz" }. Quotes may be omitted on keys, unless the key starts with a number, in which case quotes are required. Commas are required between key/value pairs for single line maps. A newline between key/value pairs is sufficient in multi-line maps.

********************* Good sample between hcl and json *********

Objects and nested objects are created using the structure shown below:

variable "ami" {
    description = "the AMI to use"
}
This would be equivalent to the following json:

{
  "variable": {
      "ami": {
          "description": "the AMI to use"
        }
    }
}
****************************

Easy to read and write (perhaps a little subjective)
Drive the Azure API
	Explain this in detail - as the new Azure Provider supported by Azure Resource Manager - AzureRM , vs the legacy provider interacts using the Service Management API

Runs on Windows and Linux
Open Source
Free (really)

What terraform is not
Not OS configuration management
Not an abstraction layer for any cloud (explain this more)
What providers does it have: https://www.terraform.io/docs/providers/

What provider resources does it have: Show list (sim to above list of providers)

************************************
Windows, Mac, Linux
Bash for Windows?
PowerShell, Bash ?? all the above, none
Consistency...best option?
************************************

Terraform Workflow
Edit Code
Plan
Apply
[Teraform Destroy] - maybe ancillary on great to destroy resources by group, but can be a pain to destroy by thing
Rinse & repeat

Terraform Security
Enforce Configuration (state)
Commit History
Delegate Azure access to a schedular (Jenkins, teamcity, vsts)
Security Concerns - keys, keys, keys


Powershell vs Bash shell

Don't write your own cloud infrastructure management tooling

Takeaways:
Don't mix manual deploy and Terraform
Start simple and build up iteratively
Establish resource naming convention quickly
Tag everything with a meaningful string
Use comments - best code practices folks
Use remote back-end/remote state file (describe / learn more about)
Ops will probably need to learn source control (git) if they haven't started




