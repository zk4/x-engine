export function isTruePhone(areaCode,phone) {
  if (areaCode == "86") {
    if (!/^[1][3-8]\d{9}$/.test(phone)) {
      return false;
    } else {
      return true;
    }
  } else if(areaCode == "886") {
    if (!/^[0][9]\d{8}$/.test(phone)) {
      return false;
    } else {
      return true;
    }
  } else if(areaCode == "852") {
    if (!/^([6|9])\d{7}$/.test(phone)) {
      return false;
    } else {
      return true;
    }
  } else if(areaCode == "853") {
    if (!/^[6]([8|6])\d{5}$/.test(phone)) {
      return false;
    } else {
      return true;
    }
  }
}
