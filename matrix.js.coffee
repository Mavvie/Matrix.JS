window.matrix = {}
window.matrix.swap = (arr, i, j) ->
  temp = arr[i]
  arr[i] = arr[j]
  arr[j] = temp
window.matrix.checkref = (data) ->
  # A matrix is in REF iff:
      # 1. Any row of zeroes is below all rows containing a non-zero entry
      # 2. A leading entry is always to the right of all leading entries above it
  ret = true
  left_index = -2;
  _.each(data, (row) ->
    i_leading_entry = _.indexOf(row, _.find(row, (col) -> col != 0))
    if i_leading_entry <= left_index
      ret = false
    left_index = i_leading_entry
  )

  return ret
window.matrix.ref = (data) ->
  ret = window.matrix._ref(data)
  last_length = ret.length
  while _.all(ret[0], (col) -> col == 0)
    ret = window.matrix._ref(_.without(ret, ret[0]))
    if ret.length == last_length
      break
    last_length = ret.length
  ret
window.matrix._ref = (indata) ->
  data = angular.copy(indata)
  n_rows = data.length
  n_cols = data[0].length
  i = 0 ; j = 0
  while i < n_rows && j < n_cols
    if data[i][j] == 0
      indexToSwap = _.indexOf(data, _.find(data, (row) -> row[j] != 0))
      if indexToSwap == -1
        j += 1
        continue
      else
        window.matrix.swap(data, i, indexToSwap)
    scale_factor = data[i][j]
    _.each(data[i], (value, index) ->
      data[i][index] = value / scale_factor
    )
    _.each(data, (row, i_row) ->
      if i_row != i
        scale_factor = data[i_row][j]
        if scale_factor != 0
          _.each(data[i_row], (value, index) ->
            data[i_row][index] = value - data[i][index] * scale_factor
          )
    )

    i += 1 ; j += 1
  return data

window.matrix.numberOfSolutions = (ref) ->
  # Assumes ref is an augmented matrix in REF (as the name implies...)
  # NOTE: The ref function above ensures linear independence.
  # If you pass a matrix in here, make sure it's linearly independent
  # A is the coefficient matrix
  # Number of solutions:
  # If columns(A) == rows
    # 1 Solution
  # If columns(A) > rows
    # Infinite solutions with {{columns(A)-rows}} solutions
  # If columns(A) < rows
    # Inconsistent
  cols = ref[0].length - 1
  rows = ref.length
  if cols == rows
    return 1
  if cols > rows
    return Infinity
  if cols < rows
    return 0

window.matrix.isSubspace = (data) ->
  # As far as my limited knowledge goes, a linear system can only be a subspace
  # if the B matrix is all zero.
  # There's probably other restrictions though?
  # Therefore: If this returns true, it MIGHT be a subspace.
  #   If it returns false, it IS NOT a subspace (for sure).
  # (as it must contain the zero vector)
  return _.all(data, (row) -> _.last(row) == 0)