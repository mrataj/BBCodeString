BBCodeString
============

A little bit bored on sunday ...

BBCodeString is a simple library which enables you to
create NSAttributedString object from bb code string.

Example of use:

    NSString *bbCode = @"[user id=\"42\"]Mary Jones[/user] sent file [file id=\"23\"]Report.pdf[/file].";
        
    BBCodeString *bbCodeString = [[BBCodeString alloc] initWithBBCode:bbCode andLayoutProvider:self];
    NSAttributedString *myString = bbCodeString.attributedString;

You can simply set visual attributes for each BB code element by setting layout provider.
