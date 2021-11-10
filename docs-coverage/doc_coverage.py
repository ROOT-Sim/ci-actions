#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
import argparse
import coverxygen
import os
import re
import sys

parser = argparse.ArgumentParser()
parser.add_argument("-b", "--build_dir", type=str, default="build",
                    help="choose the build folder where to find the doc")
parser.add_argument("-s", "--src_dir", type=str, default="..",
                    help="choose the folder where to find the sources")
parser.add_argument("-t", "--threshold", type=float, default=60.0,
                    help="The acceptance threshold")
parser.add_argument("-g", "--github", action='store_true',
                    help="format the output as a GitHub comment for CI")
args = parser.parse_args()

coverage_target = args.threshold

build_dir = args.build_dir
xml_dir = f"{build_dir}/xml/"
src_dir = args.src_dir
out_file = f"{build_dir}/coverxygen_output"
covscope = "public,protected,private".split(",")
covkind = ("enum,enumvalue,friend,typedef,variable,function,signal,slot,class,"
           "struct,union,define,file,namespace,page").split(",")
covexclude = [f"{src_dir}/README.md"]

print('BUILD DIR ', build_dir)
files = os.listdir(build_dir)
for f in files:
    print(f)
print('SRC DIR ', src_dir)
files = os.listdir(src_dir)
for f in files:
    print(f)
cov_obj = coverxygen.Coverxygen(xml_dir, out_file, covscope, covkind, "summary",
                                src_dir, None, False, covexclude, [])
try:
    cov_obj.process()
except RuntimeError as l_error:
    sys.stderr.write("error: %s\n" % str(l_error))
    sys.exit(1)

with open(out_file, "r") as f:
    summary_content = f.read()

total_line = summary_content[summary_content.find("Total"):]
doc_cov_match = next(re.finditer(r"\d*\.\d+|\d+", total_line))
acceptable = float(doc_cov_match[0]) >= coverage_target

if args.github:
    icon = ":+1" if acceptable else ":exclamation:"
    acceptable_val = 1 if acceptable else 0
    message = "COMMENT="
    message += f"\"Documentation coverage is **{doc_cov_match[0]}%** {icon}\\n"
    message += "```\\n"
    message += summary_content.replace("\n", "\\n")
    message += "```\\n\"\n"
    message += f"acceptable={acceptable_val}\n"
    with open(os.environ['GITHUB_ENV'], "w") as f:
        f.write(message)

acceptable_str = "" if acceptable else "not "
print(summary_content)
print(f"Documentation coverage is {acceptable_str}acceptable "
      f"(target: {coverage_target}%)")
