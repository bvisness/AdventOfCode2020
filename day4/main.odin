package main

import "core:fmt"
import "core:strconv"
import "core:strings"

main :: proc() {
    input := string(#load("input.txt"));

    passports := strings.split(input, "\n\n");

    for passport, i in passports {
        passports[i], _ = strings.replace_all(passport, "\n", " ");
    }

    numValid := 0;

    passports_split := make([dynamic][dynamic][2]string);
    for passport in passports {
        foundFields := [7]bool{};

        for pair in strings.split(passport, " ") {
            if pair == "" {
                continue;
            }

            tokens := strings.split(pair, ":");
            key := tokens[0];
            val := tokens[1];

            fmt.println(key, val);

            switch key {
                case "byr":
                    if len(val) == 4 {
                        valNum, _ := strconv.parse_int(val);
                        foundFields[0] = 1920 <= valNum && valNum <= 2002;
                    }
                case "iyr":
                    if len(val) == 4 {
                        valNum, _ := strconv.parse_int(val);
                        foundFields[1] = 2010 <= valNum && valNum <= 2020;
                    }
                case "eyr":
                    if len(val) == 4 {
                        valNum, _ := strconv.parse_int(val);
                        foundFields[2] = 2020 <= valNum && valNum <= 2030;
                    }
                case "hgt":
                    measure := val[0:len(val)-2];
                    unit := val[len(val)-2:len(val)];
                    measureNum, _ := strconv.parse_int(measure);

                    switch unit {
                        case "cm":
                            foundFields[3] = 150 <= measureNum && measureNum <= 193;
                        case "in":
                            foundFields[3] = 59 <= measureNum && measureNum <= 76;
                    }
                case "hcl":
                    if len(val) == 7 {
                        valid := true;

                        if val[0] != '#' {
                            valid = false;
                        }

                        for c in val[1:] {
                            if !(('0' <= c && c <= '9') || ('a' <= c && c <= 'f')) {
                                valid = false;
                            }
                        }

                        foundFields[4] = valid;
                    }
                case "ecl":
                    foundFields[5] = val == "amb" || val == "blu" || val == "brn" || val == "gry" || val == "grn" || val == "hzl" || val == "oth";
                case "pid":
                    if len(val) == 9 {
                        valid := true;
                        for c in val {
                            if !('0' <= c && c <= '9') {
                                valid = false;
                            }
                        }
                        foundFields[6] = valid;
                    }

                case "cid":
                    // ignore!
            }
        }

        fmt.println(foundFields);

        valid := true;
        for fieldFound in foundFields {
            if !fieldFound {
                valid = false;
                break;
            }
        }

        if valid {
            numValid += 1;
        }
    }

    fmt.println(numValid, "passports were valid.");
}
