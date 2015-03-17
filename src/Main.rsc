@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module Main

import framework::Checker;
import framework::FrontEnd;
import framework::GlueRunner;

// Checks for unused/broken/empty/forgotten artefacts in the Grammar Zoo
void cmain() = framework::Checker::cmain();

// Generates the main HTML front page of the Grammar Zoo
void fmain() = framework::FrontEnd::main();

// Runs all the GLUEs in the Grammar Zoo
void gmain() = framework::GlueRunner::gmain();
