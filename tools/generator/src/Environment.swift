import PathKit
import XcodeProj

/// Provides `Generator`'s dependencies.
///
/// The main purpose of `Environment` is to enable dependency injection,
/// allowing for different implementations to be used in tests.
struct Environment {
    let createProject: (
        _ project: Project,
        _ projectRootDirectory: Path
    ) -> PBXProj

    let processTargetMerges: (
        _ targets: inout [TargetID: Target],
        _ targetMerges: [TargetID: Set<TargetID>]
    ) throws -> Void

    let createFilesAndGroups: (
        _ pbxProj: PBXProj,
        _ targets: [TargetID: Target],
        _ extraFiles: Set<FilePath>,
        _ filePathResolver: FilePathResolver
    ) throws -> (
        files: [FilePath: File],
        rootElements: [PBXFileElement]
    )

    let createProducts: (
        _ pbxProj: PBXProj,
        _ targets: [TargetID: Target]
    ) -> (Products, PBXGroup)

    let populateMainGroup: (
        _ mainGroup: PBXGroup,
        _ pbxProj: PBXProj,
        _ rootElements: [PBXFileElement],
        _ productsGroup: PBXGroup
    ) -> Void

    let disambiguateTargets: (
        _ targets: [TargetID: Target]
    ) -> [TargetID: DisambiguatedTarget]
    
    let addTargets: (
        _ pbxProj: PBXProj,
        _ disambiguatedTargets: [TargetID: DisambiguatedTarget],
        _ products: Products,
        _ files: [FilePath: File],
        _ filePathResolver: FilePathResolver,
        _ xcodeprojBazelLabel: String
    ) throws -> [TargetID: PBXNativeTarget]

    let setTargetConfigurations: (
        _ pbxProj: PBXProj,
        _ disambiguatedTargets: [TargetID: DisambiguatedTarget],
        _ pbxTargets: [TargetID: PBXNativeTarget],
        _ filePathResolver: FilePathResolver
    ) throws -> Void

    let setTargetDependencies: (
        _ disambiguatedTargets: [TargetID: DisambiguatedTarget],
        _ pbxTargets: [TargetID: PBXNativeTarget]
    ) throws -> Void

    let createXcodeProj: (_ pbxProj: PBXProj) -> XcodeProj

    let writeXcodeProj: (
        _ xcodeProj: XcodeProj,
        _ files: [FilePath: File],
        _ internalDirectoryName: String,
        _ outputPath: Path
    ) throws -> Void
}
