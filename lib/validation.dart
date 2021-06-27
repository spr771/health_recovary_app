bool is_empty(String value) {
  return (value == null || value.isEmpty);
}

bool is_name(String value) {
  return RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value);
}

bool is_email(String value) {
  if (value == '')
    return true;
  else
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value);
}

bool is_password(String value) {
  return (value.length < 6 ||
      (!value.contains(new RegExp(r'[A-Z]')) &&
          !value.contains(new RegExp(r'[a-z]'))) ||
      !value.contains(new RegExp(r'[0-9]')));
}

bool is_contact(String value) {
  return (value.length == 10 && RegExp(r'[0-9]').hasMatch(value));
}

String capitalize(String value) {
  if (value == null || value == '') {
    return null;
  } else {
    return "${value[0].toUpperCase()}${value.substring(1)}";
  }
}
String SentenceCase(String value) {
  if (value == null || value == '') {
    return null;
  } else {
    List<String> list = value.trim().split(' ');

    for (int i = 0; i < list.length; i++)
      list[i] = capitalize(list[i].toLowerCase());
    return list.join(" ");
  }
}
