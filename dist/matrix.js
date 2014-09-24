window.matrix = {};

window.matrix.swap = function(arr, i, j) {
  var temp;
  temp = arr[i];
  arr[i] = arr[j];
  return arr[j] = temp;
};

window.matrix.checkref = function(data) {
  var left_index, ret;
  ret = true;
  left_index = -2;
  _.each(data, function(row) {
    var i_leading_entry;
    i_leading_entry = _.indexOf(row, _.find(row, function(col) {
      return col !== 0;
    }));
    if (i_leading_entry <= left_index) {
      ret = false;
    }
    return left_index = i_leading_entry;
  });
  return ret;
};

window.matrix.ref = function(data) {
  var last_length, ret;
  ret = window.matrix._ref(data);
  last_length = ret.length;
  while (_.all(ret[0], function(col) {
      return col === 0;
    })) {
    ret = window.matrix._ref(_.without(ret, ret[0]));
    if (ret.length === last_length) {
      break;
    }
    last_length = ret.length;
  }
  return ret;
};

window.matrix._ref = function(indata) {
  var data, i, indexToSwap, j, n_cols, n_rows, scale_factor;
  data = angular.copy(indata);
  n_rows = data.length;
  n_cols = data[0].length;
  i = 0;
  j = 0;
  while (i < n_rows && j < n_cols) {
    if (data[i][j] === 0) {
      indexToSwap = _.indexOf(data, _.find(data, function(row) {
        return row[j] !== 0;
      }));
      if (indexToSwap === -1) {
        j += 1;
        continue;
      } else {
        window.matrix.swap(data, i, indexToSwap);
      }
    }
    scale_factor = data[i][j];
    _.each(data[i], function(value, index) {
      return data[i][index] = value / scale_factor;
    });
    _.each(data, function(row, i_row) {
      if (i_row !== i) {
        scale_factor = data[i_row][j];
        if (scale_factor !== 0) {
          return _.each(data[i_row], function(value, index) {
            return data[i_row][index] = value - data[i][index] * scale_factor;
          });
        }
      }
    });
    i += 1;
    j += 1;
  }
  return data;
};

window.matrix.numberOfSolutions = function(ref) {
  var cols, rows;
  cols = ref[0].length - 1;
  rows = ref.length;
  if (cols === rows) {
    return 1;
  }
  if (cols > rows) {
    return Infinity;
  }
  if (cols < rows) {
    return 0;
  }
};

window.matrix.isSubspace = function(data) {
  return _.all(data, function(row) {
    return _.last(row) === 0;
  });
};

