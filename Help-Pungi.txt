Pungi doesn't call mkisofs with the -f argument so it doesn't follow symlinks.
Since our repos are managed via symlinks we need to extend and modify the base class in question.

I'm starting with pungi-2.0.22.
