The pkglist.* files in this directory, while generated,
are intentionally kept in revision control.  Storing
these in revision control ensures you can identify exact
package versions used to roll an ISO at any later point
int time. 

It is these files that are used to populate CLIP's own
yum repos with packages.  Your yum repos can continue to 
evolve and update over time, adding newer and new packages.
But, as long as these pkstlist files are here, and your
yum repos contain a superset of all of the packages, which
is typically for everything except EPEL, you can easily
re-create a specific image later.

E.g., let's say you produce a product's Gold Master/RTM
ISO.  Following good CM procedures, you tag the source
code used when it is released.  Two years later you want 
to reprorduce that ISO from that tag.  Had we not stored
these pkglist files in revision control, and used these
package lists to populate CLIP's yum repo, you would be
stuck trying to figure out what you included in the ISO.
While not a silver bullet, and while there are other ways
to accomplish something similar, this is just another tool
that can help in a CM process.
