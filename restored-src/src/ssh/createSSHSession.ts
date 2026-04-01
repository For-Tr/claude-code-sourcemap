// Stub: ssh/createSSHSession (not restored from sourcemap)
export class SSHSessionError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'SSHSessionError'
  }
}

export function createSSHSession(_opts: unknown): never {
  throw new SSHSessionError('SSH session support not available in this build')
}

export function createLocalSSHSession(_opts: unknown): never {
  throw new SSHSessionError('Local SSH session support not available in this build')
}
