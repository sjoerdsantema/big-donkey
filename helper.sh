#!/bin/bash
clear
. helper.conf 
echo " "
cat sentia.txt
echo " "
echo "Stack we're working on is:" $stack
echo "The bucket we're getting our templates from and to is:" $bucket
echo "We're loading this template when updating:" $template  
echo "--------------------------------------------------------------------------------------------"
echo " "
echo "What would you like to do? Choices are: sync, delete, create or quit:" 
read wish

if [ "$wish" == "create" ] ; then
        echo "As you wish, we shall create a new stack."
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
elif [ "$wish" == "quit" ] ; then
        echo "Goodbye.."  
        exit 1
else
        echo "Please adhere to my command. I am giving you a second chance"
        sleep 2
        clear
        ./helper.sh
fi





