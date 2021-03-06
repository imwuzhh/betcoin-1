[= AutoGen5 template texi

##  Documentation template
##
## Time-stamp:        "2010-02-24 08:41:30 bkorb"
## Author:            Bruce Korb <bkorb@gnu.org>
##
##  This file is part of AutoOpts, a companion to AutoGen.
##  AutoOpts is free software.
##  AutoOpts is Copyright (c) 1992-2010 by Bruce Korb - all rights reserved
##
##  AutoOpts is available under any one of two licenses.  The license
##  in use must be one of these two and the choice is under the control
##  of the user of the license.
##
##   The GNU Lesser General Public License, version 3 or later
##      See the files "COPYING.lgplv3" and "COPYING.gplv3"
##
##   The Modified Berkeley Software Distribution License
##      See the file "COPYING.mbsd"
##
##  These files have the following md5sums:
##
##  43b91e8ca915626ed3818ffb1b71248b pkg/libopts/COPYING.gplv3
##  06a1a2e4760c90ea5e1dad8dfaac4d39 pkg/libopts/COPYING.lgplv3
##  66a5cedaf62c4b2637025f049f9b826f pkg/libopts/COPYING.mbsd
##
## ---------------------------------------------------------------------
## $Id$
## ---------------------------------------------------------------------

(setenv "SHELL" "/bin/sh")

=]
@node [= prog-name =] Invocation
@[=
 (define down-prog-name (string-downcase! (get "prog-name")))
 (define doc-level (getenv "LEVEL"))
 (if (not (string? doc-level))
     (set! doc-level "section"))

 doc-level =] Invoking [= prog_name =]
@pindex [= prog-name  =]
@cindex [= prog-title =][=

FOR concept =]
@cindex [= concept =][=
ENDFOR

=]
@ignore
[=
 (out-push-new (string-substitute (out-name) ".texi" ".menu"))

 (sprintf "* %-32s Invoking %s\n"
  (string-append (get "prog-name") " Invocation::")
  (get "prog-name") )

=][=

  (out-pop)
  (dne "# " "# ")=]
@end ignore
[= ?% explain %s "This program has no explanation.\n" =]
[=
IF (exist? "prog-info-descrip")  =][=
  FOR prog-info-descrip  "\n\n"  =][=
    prog-info-descrip            =][=
  ENDFOR                         =][=
ELIF (exist? "detail")           =][=
  detail                         =][=
ENDIF
=]

This [=(string-downcase doc-level)=] was generated by @strong{AutoGen},
the aginfo template and the option descriptions for the @command{[=
prog-name =]} program.  It documents the [=
prog-name =] usage text and option meanings.[=

IF (exist? "copyright") =]

This software is released under [=
  CASE copyright.type =][=
   =  gpl =]the GNU General Public License[=
   = lgpl =]the GNU General Public License with Library Extensions[=
   =  bsd =]the Free BSD License[=
   *      =]a specialized copyright license[=
  ESAC =].[=
ENDIF =]

@menu
* [=(sprintf "%s %-24s %s" down-prog-name "usage::" (get "prog-name"))
  =] usage help[=
     (if (exist? "flag.value") " (-?)") =]
[=(out-push-new (string-append (out-name) ".tmp"))
  (shell (string-append "f=" (out-name))) =][=
FOR flag =][=
  IF (not (exist? "documentation"))
=]* [=(sprintf
         "%s %-24s"
         (. down-prog-name)
         (string-append
            (string-tr! (get "name") "A-Z^_" "a-z--" )
            "::" ) )
     =] [=% name (string-tr! "%s" "A-Z^_" "a-z--")=] option[=
          % value " (-%s)" =]
[=ENDIF =][=
ENDFOR flag=][=
(out-pop) =][=
`sort $f ; rm -f $f` =]
@end menu

@node [=(. down-prog-name)=] usage
@[=CASE (. doc-level)=][=
   = chapter    =][=
   = section    =]sub[=
   = subsection =]subsub[=
   ESAC =]section [=prog-name=] usage help[=
     (if (exist? "flag.value") " (-?)") =]
@cindex [=(. down-prog-name)=] usage

This is the automatically generated usage text for [=prog-name=]:

@exampleindent 0
@example
[= (shellf "PROG=./%1$s

    if [ ! -f ${PROG} ]
    then PROG=./`echo $PROG | tr '[A-Z]' '[a-z]'` ; fi

    if [ ! -f ${PROG} ]
    then PROG=./`echo $PROG | tr x_ x-` ; fi

    if [ ! -f ${PROG} ]
    then if %1$s %2$s > /dev/null 2>&1
         then PROG=%1$s
         else PROG='echo %1$s is unavailable - no'
    fi ; fi

    ${PROG} %2$s 2>&1 | \
        sed -e 's/USAGE:  lt-/USAGE:  /' \
            -e 's/@/@@/g;s/{/@{/g;s/}/@}/g' \
            -e 's/\t/        /g' "

    (get "prog-name")

    (if (exist? "long_opts")       "--help"
        (if (exist? "flag.value")  "-?"
                                   "help" ))

    )  =]
@end example
@exampleindent 4[=

#  FOR all options, except the `documentation' options, ...  =][=

IF (define opt-name "")
   (define extra-ct 0)
   (define extra-text "")
   (exist? "preserve-case")     =][=
   (define optname-from "_^")
   (define optname-to   "--")   =][=
ELSE                            =][=
  (define optname-from "A-Z_^")
  (define optname-to   "a-z--") =][=
ENDIF                           =][=

FOR flag=][=

  IF (not (exist? "documentation")) =]

@node [=
    (set! opt-name (string-tr! (get "name") optname-from optname-to))
    (string-append down-prog-name " " opt-name)=]
@[=CASE (. doc-level) =][=
   = chapter    =][=
   = section    =]sub[=
   = subsection =]subsub[=
   ESAC =]section [=(. opt-name)=] option[=
          % value " (-%s)" =]
@cindex [=(. down-prog-name)=]-[=(. opt-name)=]

This is the ``[=(string-downcase! (get "descrip"))=]'' option.[=
    (set! extra-ct 0)
    (out-push-new)  =][=

    IF (exist? "min") =]@item
is required to appear on the command line.
[=    (set! extra-ct (+ extra-ct 1)) =][=
    ENDIF=][=

    IF (exist? "max") =]@item
may appear [=
      IF % max (= "%s" "NOLIMIT")
         =]an unlimited number of times[=
      ELSE
         =]up to [=max=] times[=
      ENDIF=].
[=    (set! extra-ct (+ extra-ct 1)) =][=
    ENDIF=][=

    IF (exist? "enabled") =]@item
is enabled by default.
[=    (set! extra-ct (+ extra-ct 1)) =][=
    ENDIF=][=

    IF (exist? "ifdef") =]@item
must be compiled in by defining @code{[=(get "ifdef")
      =]} during the compilation.
[=    (set! extra-ct (+ extra-ct 1)) =][=
    ENDIF =][=

    IF (exist? "ifndef") =]@item
must be compiled in by @strong{un}-defining @code{[=(get "ifndef")
      =]} during the compilation.
[=    (set! extra-ct (+ extra-ct 1)) =][=
    ENDIF=][=

    IF (exist? "no_preset") =]@item
may not be preset with environment variables
or in initialization (rc) files.
[=    (set! extra-ct (+ extra-ct 1)) =][=
    ENDIF=][=

    IF (exist? "equivalence") =]@item
is a member of the [=equivalence=] class of options.
[=    (set! extra-ct (+ extra-ct 1)) =][=
    ENDIF=][=

    IF (exist? "flags_must") =]@item
must appear in combination with the following options:
[=    FOR flags_must ", " =][=flags_must=][=
      ENDFOR=].
[=    (set! extra-ct (+ extra-ct 1)) =][=
    ENDIF=][=

    IF (exist? "flags_cant") =]@item
must not appear in combination with any of the following options:
[=    FOR flags_cant ", " =][=flags_cant=][=
      ENDFOR=].
[=    (set! extra-ct (+ extra-ct 1)) =][=
    ENDIF=][=

    IF  (~* (get "arg-type") "key|set") =]@item
This option takes a keyword as its argument[=

      CASE arg-type   =][=
      =* key          =][= (set! extra-ct (+ extra-ct 1)) =].
The argument sets an enumeration value that can be tested by comparing[=

      =* set          =][= (set! extra-ct (+ extra-ct 1)) =] list.
Each entry turns on or off membership bits.  These bits can be tested
with bit tests against[=
      ESAC arg-type   =] the option value macro ([=
(string-upcase (string-append
(if (exist? "prefix") (string-append (get "prefix") "_") "")
"OPT_VALUE_" (get "name")  )) =]).
The available keywords are:
@example
[= (shellf "${CLexe:-columns} --spread=1 -W50 <<_EOF_\n%s\n_EOF_"
            (join "\n" (stack "keyword"))  ) =]
@end example
[=

      IF (=* (get "arg-type") "key") =]
or their numeric equivalent.[=
      ENDIF =][=

    ENDIF key/set arg =][=

    IF (> extra-ct 0) =][=
      (set! extra-text (out-pop #t)) =]

This option has some usage constraints.  It:
@itemize @bullet
[=(. extra-text)
=]@end itemize
[=  ELSE  =][=
      (out-pop) =][=
    ENDIF =][=

?% doc "\n%s" "\nThis option has no @samp{doc} documentation." =][=


  ENDIF  `documentation' exists =][=
  IF (exist? "deprecated") =]

@strong{NOTE: THIS OPTION IS DEPRECATED}[=

  ENDIF     =][=
ENDFOR flag =][= #

aginfo.tpl ends here =]
