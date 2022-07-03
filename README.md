# Log Parser

`log_parser` helps to organize your log records.

Steps:
  1. Copy the repo into your folder.
  2. Run `bundle install` to install all dependencies.
  3. Run `./log_parser.rb webserver.log` while `webserver.log` is the log file.
  4. The script will print:
  
  - list of webpages with most page views ordered from most pages views to less page views
    
    ```
    /home 90 visits
    /index 80 visits
    ...omitted...
    ```
    
 - unique page views also ordered
    ```
    /about/2 8 unique views
    /index 5 unique views
    ...omitted...
    ```
