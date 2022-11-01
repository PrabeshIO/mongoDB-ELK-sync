module.exports = function (doc) {
  var requiredData = Object.keys(doc);
  var result = {};
  for (var i = 0; i < requiredData.length; i++) {
    var key = requiredData[i];
    if (doc[key]) {
      if (key === "createdAt" || key === "updatedAt") {
        result[key] = doc[key];
      } else {
        result[key] = JSON.stringify(doc[key]);
      }
    }
  }
  return result;
};
