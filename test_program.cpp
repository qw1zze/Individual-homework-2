#include <iostream>

double f(double x) {
	return x * x * x - 0.5 * x * x + 0.2 * x - 4;
}


double find_x(double (*f)(double), double a, double b, double eps) {
	double c;
	while ((b - a) / 2 > eps) {
		c = (a + b) / 2;
		if ((f(a) * f(c)) > 0) a = c;
		else b = c;
	}
	return c;
}

bool check_interval(double (*f)(double), double a, double b) {
	return f(a) * f(b) <= 0 && a <= b;
}

int main() {
	
	double check_f[6][2] = { {1.0, -3.3}, {2.0, 2.4}, {-1.0, -5.7}, {-2.0, -14.4}, {-5.5, -186.6}, {9.9, 919.274} };

	std::cout << "Testing program f:\n\n";

	int count_correct = 0, count = 0;
	for (int i = 0; i < 6; ++i) {
		if (std::abs(f(check_f[i][0]) - check_f[i][1]) < 0.000000001) {
			std::cout << "Test passed\n";
			++count_correct;
		} else {
			std::cout << "Test failed\n";
		}
		++count;
	}
	std::cout << "\nCount of passed tests: " << count_correct << " of " << count;

	double check_find_x[6][4] = { 
		{1.0, 2.0, 0.00001, 1.72633}, 
		{1.0, 2.0, 0.001, 1.7246}, 
		{1.0, 2.0, 0.000001, 1.7263314}, 
		{-5.0, 13.0, 0.00001, 1.72633}, 
		{1.0, 13.0, 0.001, 1.7246}, 
		{1.3, 1.8, 0.0001, 1.726331468} 
	};

	std::cout << "\n\nTesting program find_x:\n\n";

	count_correct = 0;
	count = 0;
	for (int i = 0; i < 6; ++i) {
		if (std::abs(find_x(f, check_find_x[i][0], check_find_x[i][1], check_find_x[i][2]) - check_find_x[i][3]) < check_find_x[i][2]) {
			std::cout << "Test passed\n";
			++count_correct;
		}
		else {
			std::cout << "Test failed\n";
			std::cout << std::abs(find_x(f, check_find_x[i][0], check_find_x[i][1], check_find_x[i][2]) - check_find_x[i][3]);
		}
		++count;
	}
	std::cout << "\nCount of passed tests: " << count_correct << " of " << count;

	double check_check_interval[6][3] = {
		{1.0, 2.0, 1},
		{1.0, 7.0, 1},
		{-5.0, 1.8, 1},
		{3.0, 2.0, 0},
		{7.0, 1.0, 0},
		{2.0, 2.0, 0}
	};

	std::cout << "\n\nTesting program check_interval:\n\n";

	count_correct = 0;
	count = 0;
	for (int i = 0; i < 6; ++i) {
		if (check_interval(f, check_check_interval[i][0], check_check_interval[i][1]) == (int)check_check_interval[i][2]) {
			std::cout << "Test passed\n";
			++count_correct;
		}
		else {
			std::cout << "Test failed\n";
			std::cout << check_interval(f, check_check_interval[i][0], check_check_interval[i][1]);
		}
		++count;
	}
	std::cout << "\nCount of passed tests: " << count_correct << " of " << count;
}