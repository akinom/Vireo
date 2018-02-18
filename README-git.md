## develop  locally 

```
git co master 
git co -b new-branch 
	// do not make changes that are specific to a particular deployment 
	// eg setting authentication methods or db hosts 
git push 
```
### test in qa 

```
git co qa
gitnffmerge new-branch
git push 
```

deploy to QA server 


### approve for production 
```git co master 
gitnffmerge new-branch 

git co qa
git rebase master 

git diff --stat qa master  
git push 
git co master 
git push 
```

deploy to production server 




