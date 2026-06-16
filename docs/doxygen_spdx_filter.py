#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2008-2025 HPCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
import re
import sys

website = "https://hpdcs.github.io"

with open(sys.argv[1], 'r') as f:
    file_text = f.read()

file_text = re.sub(r"SPDX-FileCopyright" r"Text: 2008-([0-9]{4}) HPCS Group .*>",
                   r"@copyright Copyright (C) 2008-\1 HPCS Group " + website, file_text)
file_text = re.sub(r"SPDX-License-" r"Identifier:.*", "", file_text)
file_text = re.sub(r"SPDX-FileCopyright" r"Text:", "@copyright", file_text)

print(file_text)
