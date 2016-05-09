/*
 * Run stuff on root window clicks
 */

#include <X11/Xlib.h>
#include <X11/Xresource.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main()
{
    Display *dpy;
    XEvent ev;
    XSetWindowAttributes wa;

    GC gc;

/*    XrmDatabase db;
    XrmValue up;
    XrmValue down;
    XrmValue left;
    XrmValue right;
    char xdb_path[128];
    char *type;*/

    int x, y;


    if (!(dpy = XOpenDisplay(NULL))) {
        fprintf(stderr, "Could not open display %s", getenv("DISPLAY"));
    }

    int black = BlackPixel(dpy, DefaultScreen(dpy));
    int white = WhitePixel(dpy, DefaultScreen(dpy));

    wa.override_redirect = True;

    Window w = XCreateWindow(dpy, DefaultRootWindow(dpy), 0, 0, 100, 40, 0, DefaultDepth(dpy, DefaultScreen(dpy)), CopyFromParent, DefaultVisual(dpy, DefaultScreen(dpy)), CWOverrideRedirect | CWEventMask, &wa);

    gc = XCreateGC(dpy, w, 0, NULL);

    XSelectInput(dpy, w, StructureNotifyMask);

//    sprintf(xdb_path, "%s/.rootdragrc", getenv("HOME"));

/*    XrmInitialize();

    db = XrmGetFileDatabase(xdb_path);

    XrmGetResource(db, "up", "up", &type, &up);
    XrmGetResource(db, "down", "down", &type, &down);
    XrmGetResource(db, "left", "left", &type, &left);
    XrmGetResource(db, "right", "right", &type, &right);*/
    XGrabButton(dpy, 2, 0, DefaultRootWindow(dpy), True, ButtonPressMask, GrabModeSync, GrabModeAsync, None, None);

    for (;;) {
        XNextEvent(dpy, &ev);

        if (ev.type == ButtonPress) {
            if (ev.xbutton.subwindow == None) { /* Root Window */
                /* Grab pointer so we receive ButtonRelease */
                XGrabPointer(dpy, DefaultRootWindow(dpy), True, PointerMotionMask | ButtonReleaseMask, GrabModeAsync, GrabModeAsync, None, None, CurrentTime);
                x = ev.xbutton.x_root;
                y = ev.xbutton.y_root;

                // Open Window
                XMapWindow(dpy, w);
                XMoveWindow(dpy, w, ev.xbutton.x_root + 20, ev.xbutton.y_root + 20);
            }

            XAllowEvents(dpy, ReplayPointer, CurrentTime); /* Allow other apps to process this message */
        } else if (ev.type == MotionNotify) {
            while (XCheckTypedEvent(dpy, MotionNotify, &ev));

            // Update Window Position
            XMoveWindow(dpy, w, ev.xbutton.x_root + 20, ev.xbutton.y_root + 20);
        } else if (ev.type == ButtonRelease) {
            XUngrabPointer(dpy, CurrentTime);
            XUnmapWindow(dpy, w);

            XSync(dpy, 1);

/*            char shell_buff[256];

            sprintf(shell_buff, "%s &", button[ev.xbutton.button-1].addr);

            system(shell_buff);*/
        } else if (ev.type == Expose) {
            while (XCheckTypedEvent(dpy, Expose, &ev));

//            XSetForeground(dpy, gc, black);

//            XDrawRectangle(dpy, w, gc, 1, 1, 100, 40);
        }
    }

    XDestroyWindow(dpy, w);

    XCloseDisplay(dpy);

    return 0;
}
