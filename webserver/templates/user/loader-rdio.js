var xhr = new XMLHttpRequest();
xhr.open('GET', encodeURI('{{ base_url }}?user_token={{ user_token }}&rdio_username={{ rdio_username }}'));
xhr.onload = function(content) {
  eval(xhr.response);
};
xhr.send();
