echo === vimrc diff ===
diff -u ~/.vimrc _vimrc
echo

echo === gvimrc diff ===
diff -u ~/.gvimrc _gvimrc
echo

echo === vimfiles diff ===
diff -x yankring_history.txt -uqr ~/.vim vimfiles
echo

