// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
  $(document).ready(function() {
        $("input:password").chromaHash({bars: 3, salt:"00b52c0657dabd0e71c7b9dbae6c3df", minimum:8});
    });