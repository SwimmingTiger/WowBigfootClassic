LibDebug ReadMe

LibDebug is a tool to aid with debugging AddOns.

It does the following:

* Generates errors when using undefined variables.
* Generates errors when setting global variables.
* Replaces the print function. Prints the file and line the print function was called from, colours values by their type, escapes unprintable characters in strings, and turns tables into clickable links.
* Replaces the coroutine.resume function. If the resumed coroutine generates an error, it invokes the global error handler with a string containing the error message and the coroutine's stack appended.
* Replaces the coroutine.wrap function, reimplementing it using the replacement coroutine.resume function.
* Replaces the next and pairs functions, to detect if you're try to iterate through the proxy _G object, and instead iterate through the real _G object.

It does NOT do the following:

* Catch and display errors, use BugSack or Swatter for that.

To use it, call LibDebug() at the top of any lua file you want to use the above features in.

LibDebug operates by replacing the environment of the function that called it, so that its modifications only affect AddOns that explicitly request them.

While LibDebug is embedable, you probably don't want to do that. You'll probably want to make it an optional dependency, then you can put

	if LibDebug then LibDebug() end

at the top of a source file instead, and have it work properly whether or not the AddOn is available. If you want to go that route, then feel free to use LibDebug as a flag for enabling other debug features in your AddOn as well, which you can turn on or off simply by enabling or disabling LibDebug.

The purpose of catching the use of global variables is to detect misnamed variables and variables that were intended to be local, but not declared as such.

If LibDebug complains about something you actually intended, the correct thing to do is usually to access the variable directly through _G. For example,

	my_global_variable = 42

	function MyFunction()
		print(my_global_variable)
	end

should be written as:

	_G.my_global_variable = 42

	function _G.MyFunction()
		print(my_global_variable)
	end

Note that once you set a variable through _G, it become exempt from generating errors. This won't generate any errors:

	_G.foo = nil
	foo = "floor"
	foo = foo.."caek"

You can generally use variables from the global environment without any errors, as long as they are not nil, or were set through _G. If you want to use a global variable created by another AddOn that might be nil, you need to use _G in this case as well.
In order to collect LibDebug outut in a specific chat, create a new window and rename it to "LibDebug"
