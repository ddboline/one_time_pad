import sys

from setuptools import setup
from setuptools.command.test import test as TestCommand
from setuptools_rust import RustExtension, Binding


class PyTest(TestCommand):
    user_options = []

    def run(self):
        self.run_command("test_rust")

        import subprocess
        import sys
        errno = subprocess.call([sys.executable, '-m', 'pytest', 'tests'])
        raise SystemExit(errno)


setup_requires = ['setuptools-rust>=0.6.1']
install_requires = []
tests_require = install_requires + ['pytest', 'pytest-benchmark']

setup(
    name='one_time_pad',
    version='0.1.0',
    classifiers=[
        'License :: OSI Approved :: MIT License',
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'Programming Language :: Python',
        'Programming Language :: Rust',
        'Operating System :: POSIX',
        'Operating System :: MacOS :: MacOS X',
    ],
    packages=['one_time_pad'],
    rust_extensions=[RustExtension('one_time_pad._one_time_pad', 'Cargo.toml', binding=Binding.PyO3)],
    install_requires=install_requires,
    tests_require=tests_require,
    setup_requires=setup_requires,
    include_package_data=True,
    zip_safe=False,
    cmdclass=dict(test=PyTest)
)
