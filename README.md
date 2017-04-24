# Parser from r.onliner.by/ak/

Need enter instruction:

--output [#{output file format(txt or csv)}], sorted by #{filters(price)}

Example: 
--output [txt], sorted by price
Usage: outparse [options]
    -r, --rooms room,1_room,2_rooms  Enter number of rooms
    -m, --metro red_line,blue_line   Enter line of metro.
        --price_min 50               Enter the minimum price.
        --price_max 8500             Enter the maximum price.
    -o, --owner                      Owner
    -t, --type TYPE                  Choose the type of file to save: text or csv.
    -h, --help                       Show this message
