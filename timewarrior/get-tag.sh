tag=$(timew | awk "/Tracking/{print \$NF}")
if [[ -z "$tag" ]]; then
    tag="NO TAG"
fi;
echo $tag
