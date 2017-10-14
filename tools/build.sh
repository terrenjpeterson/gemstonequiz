#!/bin/bash
# create a build package for Alexa skill, stage in a s3 bucket, and overlay in lambda

# change directory to where source files reside
cd ../src

# create build package
zip -r trivia.zip index.js package.json questions.js node_modules/

# stage to a s3 bucket
aws s3 cp trivia.zip s3://gemstonetrivia/binaries/

# cleanup temporary file
echo 'removed temp file'
rm trivia.zip

# update the lambda function with the binaries that have been staged
aws lambda update-function-code --function-name gemstoneQuizGreen --s3-bucket gemstonetrivia --s3-key binaries/trivia.zip

# wrap-up
echo 'completed new deployment'
