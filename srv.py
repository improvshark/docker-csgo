#!/usr/bin/python

hostPort = 27015
containerPort =27015

namespace = "improvshark"
name = "csgo"

import subprocess
def cmd (bashCommand):
	process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	out, err = process.communicate()
	if out:
		print out
	if err:
		print err
def update():
	print 'begin update'
	cmd("docker run  -i -t --volumes-from %s %s/%s /opt/steamcmd/steamcmd.sh +login anonymous +force_install_dir /opt/csgo +app_update 740 validate +quit"%(name,namespace,name))
def launch ():
	print 'begin launch'
	cmd("docker run  --name %s  -d -p %d:%d/udp -p %d:%d/tcp %s/%s" % (name, containerPort, hostPort, containerPort, hostPort,namespace,name) )
def start ():
	print 'starting %s'%name
	cmd("docker start %s"%name)
def build ():
	print 'begin building image'
	cmd("docker build -t %s/%s . " % (namespace,name) )
	print 'done'
def main():
        import argparse
	parser = argparse.ArgumentParser(description='Tool to manage a %s docker container' % name)
	parser.add_argument('-l','--launch', help="Launch the game", action='store_true')
	parser.add_argument('-s','--start', help="Launch the game", action='store_true')
	parser.add_argument('-b','--build', help="Build the container", action='store_true')
	parser.add_argument('-u','--update', help="upate the game within the container", action='store_true')
	arg = parser.parse_args()
	
	if arg.launch:
		launch()
	elif arg.start:
		start()
	elif arg.build:
		build()
	elif arg.update:
		update()
	elif not any(vars(arg).values()):
		parser.print_help()
main()
