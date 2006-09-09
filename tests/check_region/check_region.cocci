// --------------------------------------------------------------------
// interprocedural case
// --------------------------------------------------------------------

@@
expression req_reg_arg1, req_reg_arg2, req_reg_arg3;
@@
    request_region(req_reg_arg1, req_reg_arg2, req_reg_arg3)

@@
identifier probe;
identifier x;
expression E;
@@

// could an iso handle the release_region before continue?  but don't want it
// to match the continue in the then branch of check_region
probe(...) {
  ...
  for(...; ...; ...) {
    ...
-   if (check_region(E, req_reg_arg2)) continue;
+   if (!request_region(E, req_reg_arg2, req_reg_arg3)) continue;
    <...
+    release_region(E, req_reg_arg2);
     continue;
    ...>
+   release_region(E, req_reg_arg2);
  }
  ...
}

//@@
//@@
//
//   ...
//   probe(...)
//   <...
//   { ...
//+    release_region(req_reg_arg1, req_reg_arg2);
//     return ...;
//   }
//   ...>
//-  request_region(req_reg_arg1, req_reg_arg2, req_reg_arg3)
//   ...

// --------------------------------------------------------------------
// intraprocedural case
// --------------------------------------------------------------------

@@
expression req_reg_arg1, req_reg_arg2, req_reg_arg3;
identifier x;
@@

-   if (check_region(req_reg_arg1, req_reg_arg2))
+   if (!request_region(req_reg_arg1, req_reg_arg2, req_reg_arg3))
      { ... return ...; }
    <...
    { ...
+    release_region(req_reg_arg1, req_reg_arg2);
      return ...;
    }
    ...>
-   request_region(req_reg_arg1, req_reg_arg2, req_reg_arg3);
