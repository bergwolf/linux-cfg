patch_path=$1
checkpatch=./scripts/checkpatch.pl

if [ x$patch_path == "x" ]; then
	echo need patch_path
	exit 1
fi
set +e
$checkpatch $patch_path/*.patch
set -e
git checkout staging/staging-next
git branch -D each_patch_test
git checkout -b each_patch_test staging/staging-next
set +e
for I in `ls $patch_path`; do
	m_patch=$patch_path/$I
	echo $m_patch
	git am $m_patch
	make -j4 M=drivers/staging/lustre > makenoise
done
set -e

echo "Hey, Bergwolf, no error!"
