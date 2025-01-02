#!/bin/bash
timeout 3 npm run start
if [[ $? == 124 ]]; then
    # No exceptions thrown
    $(exit 0)
else
    $(exit 1)
fi