
organization := "xxx"

version := "1.0.0"

name := "CGRA-MG"

scalaVersion := "2.13.10" // "2.13.8"

scalacOptions ++= Seq(
  "-language:reflectiveCalls",
  "-deprecation",
  "-feature",
  "-Xcheckinit",
  "-P:chiselplugin:genBundleElements"
)


addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.6" cross CrossVersion.full)

libraryDependencies ++= Seq(
  "edu.berkeley.cs" %% "chisel3" % "3.5.6",
  // "edu.berkeley.cs" %% "chisel-iotesters" % "1.5.3" % "test"
  // "edu.berkeley.cs" %% "chisel-iotesters" % "2.5.6" % "test",
  "edu.berkeley.cs" %% "chisel-iotesters" % "2.5.6",
  "edu.berkeley.cs" %% "chiseltest" % "0.5.1"
  //  "edu.berkeley.cs" %% "chiseltest" % "0.5.0" % "test"
)

libraryDependencies ++= Seq(
  "com.fasterxml.jackson.core" % "jackson-core" % "2.14.2",
  "com.fasterxml.jackson.core" % "jackson-annotations" % "2.14.2",
  "com.fasterxml.jackson.core" % "jackson-databind" % "2.14.2",
  "com.fasterxml.jackson.module" %% "jackson-module-scala" % "2.14.2"
)

// Keep runMain stable for large elaboration (e.g. many CGRA tiles) on older JDKs.
Compile / run / fork := true
Compile / run / javaOptions ++= Seq(
  "-Xms2G",
  "-Xmx8G",
  "-XX:-TieredCompilation",
  "-XX:CICompilerCount=1"
)

