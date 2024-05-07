diff -srq $1 $2 | grep identical | grep -v '\.git' | grep -v 'README.md' | grep -v '.txt'
