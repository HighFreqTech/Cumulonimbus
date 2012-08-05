### Scons ###
#Scons functions are order-independent
scons -Q         #quiet
Object('func.c')
Program('program', ['prog.c', 'file1.c', 'file2.c'])

