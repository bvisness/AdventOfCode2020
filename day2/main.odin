package main

import "core:fmt"
import "core:strconv"
import "core:strings"

day2 :: proc(new: bool) {
    input := string(#load("input.txt"));
    lines := strings.split(input, "\n");

    numValid := 0;

    for line in lines {
        if line == "" {
            continue;
        }

        idash := strings.index(line, "-");
        ispace := strings.index(line, " ");
        icolon := strings.index(line, ":");
        tokens := strings.split(line, " ");

        min, _ := strconv.parse_int(line[0:idash]);
        max, _ := strconv.parse_int(line[idash+1:ispace]);
        c := line[icolon-1:icolon][0];
        password := tokens[len(tokens)-1];

        if !new {
            numMatches := 0;
            for pc in password {
                if u8(pc) == c {
                    numMatches += 1;
                }
            }

            if min <= numMatches && numMatches <= max {
                numValid += 1;
            }
        } else {
            fmt.print(line, min, max, c, password[min-1], password[max-1], password);
            match1 := c == password[min-1];
            match2 := c == password[max-1];
            if (match1 || match2) && !(match1 && match2) {
                numValid += 1;
                fmt.print(" !!valid!!");
            }
            fmt.println();
        }
    }

    fmt.println(numValid, "passwords are valid");
}

main :: proc() {
    day2(true);
}
