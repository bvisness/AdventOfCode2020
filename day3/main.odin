package main

import "core:fmt"
import "core:strconv"
import "core:strings"

main :: proc() {
    input := string(#load("input.txt"));
    lines := strings.split(input, "\n");
    lines = lines[0:len(lines)-1];

    slopes := [][2]int{
        [2]int{1, 1},
        [2]int{3, 1},
        [2]int{5, 1},
        [2]int{7, 1},
        [2]int{1, 2},
    };

    treeProduct := 1;

    for slope in slopes {
        slopeR := slope[0];
        slopeD := slope[1];

        numTrees := 0;
        c := 0;
        for r := 0; r < len(lines); {
            defer {
                c = (c + slopeR) % len(lines[r]);
                r += slopeD;
            }

            if r == 0 {
                continue;
            }

            if lines[r][c] == '#' {
                numTrees += 1;
            }
        }

        fmt.println("Ouch! You hit", numTrees, "trees.");
        treeProduct *= numTrees;
    }

    fmt.println("Part 2 answer:", treeProduct);
}
