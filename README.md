Matrix.JS
=========

A simple general-purpose matrix library.

Usage
-----

Include `underscore.js` (from [here](http://underscorejs.org/)) BEFORE including matrix.js

Once you include matrix.js, you will see a `window.matrix` object.

The following functions are available to you:

`ref(matrix)`: Input a matrix (2-d array). Make sure all rows have the same number of elements (columns). Returns a 2-d array of the matrix in row echelon form (REF)

`numberOfSolutions(ref)`: Input a matrix in REF form. The output from the above `ref(matrix)` function will work fine. It will return `0` if there are no solutions, `1` if there is a unique solution, or `Infinity` if there are infinite solutions

`isSubspace(matrix)`: Returns true if the all the entities of the last column are zero. Note: This function returning true does NOT mean that it is a subspace, it just means that the system contains the zero vector.
