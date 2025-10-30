/**
 * Shiptest OpenDream linting config:
 * See https://github.com/OpenDreamProject/OpenDream/blob/master/DMCompiler/DMStandard/DefaultPragmaConfig.dm
 */

// This is the default error/warning/notice/disable setup when the user does not mandate a different file or configuration.
// If you add a new named error with a code greater than 999, please mark it here.

//1000-1999
#pragma FileAlreadyIncluded error
#pragma MissingIncludedFile error
#pragma InvalidWarningCode error
#pragma InvalidWarningCode error
#pragma InvalidFileDirDefine error
#pragma MisplacedDirective error
#pragma UndefineMissingDirective error
#pragma DefinedMissingParen error
#pragma ErrorDirective error
// Explicitly kept at warning as this is the #warn define.
#pragma WarningDirective warning
#pragma MiscapitalizedDirective error

//2000-2999
#pragma SoftReservedKeyword error
#pragma ScopeOperandNamedType error
#pragma DuplicateVariable error
#pragma DuplicateProcDefinition error
#pragma PointlessParentCall error
#pragma PointlessBuiltinCall error
#pragma SuspiciousMatrixCall error
#pragma FallbackBuiltinArgument error
#pragma PointlessScopeOperator error
#pragma PointlessPositionalArgument error
#pragma MalformedRange error
#pragma InvalidRange error
#pragma InvalidSetStatement error
#pragma InvalidOverride error
#pragma InvalidIndexOperation error
#pragma DanglingVarType error
#pragma MissingInterpolatedExpression error
#pragma AmbiguousResourcePath error
// NOTE: The next few pragmas are for OpenDream's experimental type checker
// This feature is still in development, elevating these pragmas outside of local testing is discouraged
// An RFC to finalize this feature is coming soon(TM)
// BEGIN TYPEMAKER
#pragma UnsupportedTypeCheck notice
#pragma InvalidReturnType notice
#pragma InvalidVarType notice
#pragma ImplicitNullType notice
#pragma LostTypeInfo notice
// END TYPEMAKER
#pragma UnimplementedAccess warning
#pragma UnsupportedAccess disabled

//3000-3999
#pragma EmptyBlock disabled
#pragma EmptyProc disabled // NOTE: If you enable this in OD's default pragma config file, it will emit for OD's DMStandard. Put it in your codebase's pragma config file.
#pragma UnsafeClientAccess disabled // NOTE: Only checks for unsafe accesses like "client.foobar" and doesn't consider if the client was already null-checked earlier in the proc
#pragma SuspiciousSwitchCase error
#pragma AssignmentInConditional error
#pragma PickWeightedSyntax disabled
#pragma AmbiguousInOrder error
#pragma ExtraToken error
#pragma RuntimeSearchOperator disabled

//4000-4999 - Runtime directives
//#pragma ListNegativeSizeException warning
//#pragma InitialVarOnPrimitiveException warning
