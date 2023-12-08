namespace App\Http\Controllers;
use App\Repositories\UsuarioRepository;
use Illuminate\Http\Request;

class UsuarioController extends Controller
{
    protected $usuarioRepository;

    public function __construct(UsuarioRepository $usuarioRepository)
    {
        $this->usuarioRepository = $usuarioRepository;
    }

    public function index()
    {
        $usuarios = $this->usuarioRepository->all();
        return view('usuarios.index', compact('usuarios'));
    }

    public function show($id)
    {
        $usuario = $this->usuarioRepository->find($id);
        return view('usuarios.show', compact('usuario'));
    }

    public function create()
    {
        // Mostrar formulario de creación
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            // Validación de campos
        ]);

        $usuario = $this->usuarioRepository->create($data);

        // Redirigir o realizar otras acciones después de la creación
    }

    public function edit($id)
    {
        $usuario = $this->usuarioRepository->find($id);
        return view('usuarios.edit', compact('usuario'));
    }

    public function update(Request $request, $id)
    {
        $data = $request->validate([
            // Validación de campos
        ]);

        $usuario = $this->usuarioRepository->update($id, $data);

        // Redirigir o realizar otras acciones después de la actualización
    }

    public function destroy($id)
    {
        $this->usuarioRepository->delete($id);

        // Redirigir o realizar otras acciones después de la eliminación
    }
}