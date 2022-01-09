
target_dir = "/usr/local/bin"
cmd = "pam-login-notify.sh"
target_file = $(target_dir)/$(cmd)


.PHONY: install
install:
	# this is a part of security system. Only root must be able to make any changes.
	@install -g root -o root -c $(cmd) $(target_dir)
	@./init.sh $(target_file)
