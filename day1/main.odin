package main

import "core:fmt"
import "core:strconv"
import "core:strings"

main :: proc() {
    input := string(#load("input.txt"));
    strs := strings.split(input, "\n");
    nums := make([dynamic]int, len(strs));

    for str, i in strs {
        nums[i], _ = strconv.parse_int(str);
    }

    for i in 0..<len(nums) {
        for j in i..<len(nums) {
            if nums[i] + nums[j] == 2020 {
                fmt.println("i, j:", nums[i], nums[j], nums[i] + nums[j], nums[i] * nums[j]);
            }

            for k in j..<len(nums) {
                if nums[i] + nums[j] + nums[k] == 2020 {
                    fmt.println("i, j, k:", nums[i], nums[j], nums[k], nums[i] + nums[j] + nums[k], nums[i] * nums[j] * nums[k]);
                }
            }
        }
    }
}
