#include <example.h>
#include <subdir/example.h>
#include <iostream>

int main() { 
	std::cout << "~ Hello World!" << std::endl;
	std::cout << example_function() << std::endl;
	std::cout << subdir_function() << std::endl;
	return 0;
}