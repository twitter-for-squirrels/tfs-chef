# Chef?!?!

1. Clone the repo
1. [follow this guide](http://docs.opscode.com/install_workstation.html) to install and configure chef.

	1. I personally didn't want to use the "omnibus installer", so I just did `gem install
			chef` to install. That seemed to work.
	2.  Once you can do `chef-client -v` and see something
			like 11.4.4, you're at the step called "Get the .pem files and knife.rb files", so do that. They go
			in `[repo]/.chef`, which doesn't get checked in. The step called "Create the .chef directory" explains this.
2. Maybe a good first thing to do would be to add your ssh key the users data bag, so that you'll be able to log
   in to our servers without needing a password. Copy mine from `data_bags/users/davidbernal.json` and change
   the info to yours. Choosing a username that's the same as your username on your local computer will mean less typing.

	Then upload the data bag to the chef repo by doing `knife data bag from file users data_bags/users`,
	and also commit and push it.
2. I dunno what else. We can use `knife ec2` to bring servers up and down,
  so that seems like a good thing to read about and install.
  Here is my ec2 stuff from my knife.rb:

			knife[:aws_ssh_key_id] = "ec2-test"
			knife[:availability_zone] = "us-west-1b"
			knife[:region] = "us-west-1"
			knife[:aws_access_key_id] = "[get from console]"
			knife[:aws_secret_access_key] = "[get from console]"
			# this is the ubuntu 12.04 lts ami
			knife[:image] = "ami-fe002cbb"
			knife[:flavor] = "t1.micro"

## some other stuff

So with chef, the stuff in the git repo doesn't really matter. What matters is the stuff
that's been uploaded to the chef repo on the chef server (they should have picked a different name O\_o.)

So that means that when you make changes to the files in chef, nothing happens until
you do the corresponding `knife` command, even if you git push them.

I've set our servers to automagically run chef every so often (uh, I think anyway), so
after you make a change, all the servers will get it in a few minutes. That being said,
since we have so few servers, it might be more convenient to just ssh in and run the chef
client manually by doing `sudo chef-client --once`.
