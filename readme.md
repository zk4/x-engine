# x-engine mono repo
This repo will use yarn workspace to manage.


# Code: 402 You must sign up for private packages : @org1/pkgname #1821
You need to provide --access public to the initial publication to publish a scoped package because, as Linus points out, scoped packages are private and paid by default. The publish readme doesn't show any way to provide arbitrary commands to npm, so you'll likely have to do the first publish by hand, without lerna and with npm directly.


https://github.com/lerna/lerna/issues/1821
