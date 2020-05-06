#!/bin/bash

notebook_title="Random Notes"
page_title_md="# "
link_md="[%s](%s)"

# Remove old README file and initiate new ones
for dir in $(find . -type d -name ".git" -prune -o -type d -follow -print); do
    readmefile="${dir}/README.md"
    if [[ -f $readmefile ]]; then
        # Delete old readmes
        rm $readmefile
        touch $readmefile
    fi

    # Create new readme
    if [[ $dir = "." ]]; then
        echo "${page_title_md}${notebook_title}" >> $readmefile
    else
        dir_name=$(basename $dir)
        title=$(echo "$dir_name" | sed -r 's/[_-]+/ /g')
        # Inject title for 
        echo "${page_title_md}${title}" >> $readmefile
    fi
done

# Populate new README files
for path in $(find . -type d -name ".git" -prune -o -type f -follow -print); do
    dir=$(dirname $path)
    readmefile="${dir}/README.md"
    file=$(basename $path)
    ext="${file##*.}"
    name="${file%.*}"
    title=$(echo "$name" | sed -r 's/[_-]+/ /g')

    # Only process md files
    if [[ $ext = "md" ]]; then
        # Add README of nested directories to parent directory
        if [[ $name = "README" ]]; then
            # Ignore root README
            if [[ $dir != "." ]]; then
                dir_basename=$(basename $dir)
                parent_readme="$(dirname $dir)/README.md"
                title=$(echo "$dir_basename" | sed -r 's/[_-]+/ /g')
                # Add space
                printf "\n\n" >> $parent_readme
                printf $link_md "$title" "$dir_basename/$file" >> $parent_readme
            fi
        else
            # Add space
            printf "\n\n" >> $readmefile
            printf $link_md "$title" $file >> $readmefile
        fi
    fi
done

