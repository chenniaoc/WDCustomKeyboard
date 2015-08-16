# Why I developed WDCustomKeyboard

------

A few days a go,I have read a [article](http://iphonedevwiki.net/index.php/IOHIDFamily) about exploiting private api in iOS to record anything user typed without a jailborken device.


###features
 >* Flexible type charater key sets
 you can define any charater sets you want
 
 >* Flexible keyboard skins
 >* Most things I want to say 3 times,
 Security!,Security!,Security!
    1. User can easily change the order of all keys on the keyboard(by shuffle the key set linked list).
    2. User can simple recover the default key arrangement.
    3. Anything user typed will not be persistented.
    
###Demo:

 ![Demo](https://raw.githubusercontent.com/chenniaoc/WDCustomKeyboard/master/keyboard_demo.gif)
    
###Why it more sec than built-in keyboard in iOS system.
 * iOS will persistent information user typed.[here](http://lifehacker.com/5134799/safari-the-only-sure-fire-way-to-update-iphones-auto-correct-database)
 * Malicious App will monitor sensitive infomation even on a un-jailborken i-device.
 * The data strucure underneath is hold by c struct in memory,not direct in objc.In addition to data structure, Functions like shuffle,recover,change type is implemented use C99. Because of,objc's machine code is easily to read. 
 * Finally,I highly recommend that build this  by [llvm obfuscator](https://github.com/obfuscator-llvm/obfuscator).It makes more complex instruction sets that hacker can not reverse engineering.