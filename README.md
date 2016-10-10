ORDoc documentation
-------------------
ORDoc Description is starting with `/**`
and ends with `*/`
It is allowed to have a `*` at the start of each line it will be ignored.
The Component description inside the OpenROAD components are used as headline for each component
This is done to make it possible to create a brief description on components that do not have a script, like External Userclasses,
Databaseprocedures, 3GL Procedures, Global constants and Global variables.
It is allowed to have HTML tags inside the tekst.
Line breaks are preserved.

Parameters
----------
Tag: `@param` [name] description that can span multiple lines
The datatype of the parameter is automatically extracted from the code

Tag; `@return` Describe the return type

Tag: `@see`
Specifies a link to another component.
Format: `@see [application!]component[.method()|attribute]`

Tag: `@internal`
Mark a block internal. This way it will not be part of the external documentation

`<htmltags>`
HTML Tags are allowed inside the text.
