#!/bin/bash
clear
. helper.conf 
echo " "
cat sentia.txt
echo " "
echo "Today we're working on:" $stack
echo "The bucket we're getting our templates from and to is:" $bucket
echo "We're loading this template when updating:" $template  
echo "--------------------------------------------------------------------------------------------"
echo " "
echo "What would you like to do? Choices are: sync, delete, create, git or quit:" 
read wish

if [ "$wish" == "create" ] ; then
        echo "As you wish, we shall create this new stack."
        aws cloudformation create-stack --stack-name $stack --template-url $template --capabilities CAPABILITY_IAM 
        sleep 5
        clear
        ./helper.sh 
        exit 1
elif [ "$wish" == "sync" ] ; then
        echo " "
        aws s3 sync . $bucket --exclude '*' --include '*.yaml' 
        aws cloudformation update-stack --stack-name $stack --template-url $template 
        echo "We shall bring the news to every corner and s3 bucket."
        sleep 5
        clear
        ./helper.sh 
        exit 1
elif [ "$wish" == "delete" ] ; then
        echo "We shall destroy what you have created." 
        aws cloudformation delete-stack --stack-name $stack
        sleep 5
        clear
        ./helper.sh  
        exit 1
elif [ "$wish" == "git" ] ; then
        echo "We shall bring light to all git repositories. What do you want to say in your commit?" 
        read commit 
        git add .
        git commit -m "$commit"
        git push origin master
        echo "Done. Commit message is " $commit 
        sleep 10
        clear
        ./helper.sh  
        exit 1
elif [ "$wish" == "quit" ] ; then
        echo "Goodbye.."  
        exit 1
else
        echo "Please adhere to my command. I am giving you a second chance"
        sleep 2
        clear
        ./helper.sh
fi





