# Flashcards
## About
This repository showcases a user-friendly flashcard viewer, which has been specifically designed to read data from large .xlsx/.csv files, randomize it, and present it on the terminal screen. 
Program was created because I was unable to find a suitable existing solution for my needs.

## Run
In order to run the game you ought to have Perl installed on your computer.  
You can download it:
- from [Perl.org](https://www.perl.org/get.html)
- or via chosen package manager (e.g. `sudo apt install perl` on Ubuntu)  

After that you need to install the following Perl modules:
- `Moose`
- `Spreadsheet::Read`
- `Term::ReadKey`
- `Text::CSV`

You can do it by typing the following commands in the terminal:
- `cpan install Moose`
- `cpan install Spreadsheet::Read`
- `cpan install Term::ReadKey`
- `cpan install Text::CSV`


Eventually, you can run the program by typing:
```
perl app.py <file_name> <beginning_line> <end_line>
```
In order to improve processing speed when dealing with large files, program reads only a portion of the file. Thus <beginning_line> <end_line> fields are mandatory.

## Screenshots
![Screenshot 2023-04-17 171559](https://user-images.githubusercontent.com/93160829/232531733-5fee736e-7d64-4845-aafc-3083afb96a1c.png)
