### Scons ###
$Scons functions are order-independent
scons -Q         #quiet
print "hello"
Object('func.c')
Program(['prog.c', 'file1.c', 'file2.c']) #program name deduced from the first source
Program('program', ['prog.c', 'file1.c', 'file2.c'])
Program('program', Glob('*.c'))
Program('program', Split('main.c file1.c file2.c'))
Program(source = src_files, target = 'program')
Library('foo', ['f1.c', 'f2.o', 'f3.c'])  #produce ranlibed static .a file, input can be either source or obj
    StaticLibrary('foo', ['f1.c', 'f2.c', 'f3.c']) #same as above
SharedLibrary('foo', ['f1.c', 'f2.c', 'f3.c']) #produce .so file
Program('prog.c', LIBS=['foo', 'bar'], LIBPATH=['.','..']) 

#portable way to specify object files:
      hello_list = Object('hello.c', CCFLAGS='-DHELLO')
      goodbye_list = Object('goodbye.c', CCFLAGS='-DGOODBYE')
      Program(hello_list + goodbye_list)

#environment variables
    env = Environment()
    env.Append(CCFLAGS = '-option -O3 -O1')
    flags = { 'CCFLAGS' : '-whatever -O3' }
    env.MergeFlags(flags)
    print env['CCFLAGS']
#custom build dir
    SConscript(['drivers/display/SConscript',
                'drivers/mouse/SConscript',
                'parser/SConscript',
                'utilities/SConscript'])
    SConscript('src/SConscript', variant_dir='build', duplicate=0)
#dir path
    env = Environment(CPPPATH = ['.'])
    env.Program('hello.c')
    Repository('/usr/repository1')
#environment
    platform = ARGUMENTS.get('OS', Platform())
    include = "#export/$PLATFORM/include"
    lib = "#export/$PLATFORM/lib"
    bin = "#export/$PLATFORM/bin"
    env = Environment(PLATFORM = platform,
                      BINDIR = bin,
                      INCDIR = include,
                      LIBDIR = lib,
                      CPPPATH = [include],
                      LIBPATH = [lib],
                      LIBS = 'world')
    Export('env')
    env.SConscript('src/SConscript', variant_dir='build/$PLATFORM', exports='env')
#import
    Import('env')
    env.Program('prog', ['prog.c'])
