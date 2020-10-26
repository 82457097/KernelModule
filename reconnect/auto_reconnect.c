#include<linux/module.h>
#include<linux/kernel.h>

int exe_the_shell(char filepath[]) {
	char *argv[] = {filepath, NULL};
	char *envp[] = {NULL};
	int ret;
	
	ret = call_usermodehelper(filepath, argv, envp, UMH_WAIT_EXEC);
	printk(KERN_INFO "My_module ret is %d", ret);	

	return ret ;
}

int init_module(void) {
	char filepath[] = "/home/qianwanjun/myGit/KernelModule/reconnect/auto_reconnect.sh";
	printk(KERN_INFO "My_module Init success.");
	
	exe_the_shell(filepath);

	return 0;
}


void cleanup_module(void) {
	printk(KERN_INFO "My_module Clean my moudle success.");
}

MODULE_LICENSE("GPL");
