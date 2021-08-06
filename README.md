# Makefile Template

Generic Makefile template with a good directory structure.

What I hate about makefiles is that every example out there shows a declaration of all the 
files and dependencies in the Makefile, so the Makefile is project dependent and needs to be changed every 
time dependencies between files change.

The main feature of this Makefile is Automatic Dependency Generation using gcc -M. (http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/)
Using this Makefile you never need to change the Makefile when changing project files! :)

```sh
$ make 
$ make debug (default)
$ make release
$ make clean
```
